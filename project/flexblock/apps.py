from django.apps import AppConfig


class FlexblockConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'flexblock'
    def ready(self):
        import flexblock.signals  # シグナルをインポート