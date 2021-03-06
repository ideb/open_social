<?php

namespace Drupal\social_book\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Access\AccessResult;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\Core\Routing\RouteMatchInterface;
use Drupal\Core\Session\AccountInterface;
use Drupal\Core\Url;
use Drupal\Core\Link;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides a 'BookAddBlock' block.
 *
 * @Block(
 *  id = "book_add_block",
 *  admin_label = @Translation("Book add block"),
 * )
 */
class BookAddBlock extends BlockBase implements ContainerFactoryPluginInterface {

  /**
   * The route match.
   *
   * @var \Drupal\Core\Routing\RouteMatchInterface
   */
  protected $routeMatch;

  /**
   * BookAddBlock constructor.
   *
   * @param array $configuration
   *   The given configuration.
   * @param string $plugin_id
   *   The given plugin id.
   * @param mixed $plugin_definition
   *   The given plugin definition.
   * @param \Drupal\Core\Routing\RouteMatchInterface $routeMatch
   *   The route match.
   */
  public function __construct(array $configuration, $plugin_id, $plugin_definition, RouteMatchInterface $routeMatch) {
    parent::__construct($configuration, $plugin_id, $plugin_definition);
    $this->routeMatch = $routeMatch;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
    return new static(
      $configuration,
      $plugin_id,
      $plugin_definition,
      $container->get('current_route_match')
    );
  }

  /**
   * {@inheritdoc}
   */
  public function defaultConfiguration() {
    return ['label_display' => FALSE];
  }

  /**
   * {@inheritdoc}
   *
   * Custom access logic to display the block only on current user Book page.
   */
  protected function blockAccess(AccountInterface $account) {
    $route_user_id = $this->routeMatch->getParameter('user');
    if ($account->id() == $route_user_id && $account->hasPermission("create book content")) {
      return AccessResult::allowed();
    }
    // By default, the block is not visible.
    return AccessResult::forbidden();
  }

  /**
   * {@inheritdoc}
   */
  public function build() {
    $build = [];

    $url = Url::fromUserInput('/node/add/book');
    $link_options = [
      'attributes' => [
        'class' => [
          'btn',
          'btn-primary',
          'btn-raised',
          'waves-effect',
          'brand-bg-primary',
        ],
      ],
    ];
    $url->setOptions($link_options);

    $build['content'] = Link::fromTextAndUrl($this->t('Create book page'), $url)
      ->toRenderable();

    return $build;
  }

}
