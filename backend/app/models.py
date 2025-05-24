# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class TbAtividades(models.Model):
    id_atividade = models.IntegerField(primary_key=True)
    descricao = models.CharField(max_length=50, blank=True, null=True)
    id_faixa_etaria = models.ForeignKey('TbFaixasetarias', models.DO_NOTHING, db_column='id_faixa_etaria', blank=True, null=True)
    id_dificuldade = models.ForeignKey('TbDificuldades', models.DO_NOTHING, db_column='id_dificuldade', blank=True, null=True)
    id_topico = models.ForeignKey('TbTopicos', models.DO_NOTHING, db_column='id_topico', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_atividades'


class TbAvatares(models.Model):
    id_avatar = models.IntegerField(primary_key=True)
    descricao = models.CharField(max_length=50, blank=True, null=True)
    caminho = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_avatares'


class TbCriancaAtividades(models.Model):
    pk = models.CompositePrimaryKey('id_atividade', 'id_crianca')
    id_atividade = models.ForeignKey(TbAtividades, models.DO_NOTHING, db_column='id_atividade')
    id_crianca = models.ForeignKey('TbCriancas', models.DO_NOTHING, db_column='id_crianca')
    concluida = models.BooleanField(default=False)

    class Meta:
        managed = False
        db_table = 'tb_crianca_atividades'
        unique_together = (('id_atividade', 'id_crianca'),)


class TbCriancaAvatares(models.Model):
    pk = models.CompositePrimaryKey('id_avatar', 'id_crianca')
    id_avatar = models.ForeignKey(TbAvatares, models.DO_NOTHING, db_column='id_avatar')
    id_crianca = models.ForeignKey('TbCriancas', models.DO_NOTHING, db_column='id_crianca')

    class Meta:
        managed = False
        db_table = 'tb_crianca_avatares'
        unique_together = (('id_avatar', 'id_crianca'),)


class TbCriancaTopicos(models.Model):
    pk = models.CompositePrimaryKey('id_topico', 'id_crianca')
    id_topico = models.ForeignKey('TbTopicos', models.DO_NOTHING, db_column='id_topico')
    id_crianca = models.ForeignKey('TbCriancas', models.DO_NOTHING, db_column='id_crianca')

    class Meta:
        managed = False
        db_table = 'tb_crianca_topicos'
        unique_together = (('id_topico', 'id_crianca'),)


class TbCriancas(models.Model):
    id_crianca = models.AutoField(
        primary_key=True,
        editable=False
    )
    nome = models.CharField(max_length=80, blank=True, null=True)
    dt_nascimento = models.DateField(blank=True, null=True)
    id_responsavel = models.ForeignKey('TbResponsaveis', models.DO_NOTHING, db_column='id_responsavel', blank=True, null=True)
    id_dificuldade = models.ForeignKey('TbDificuldades', models.DO_NOTHING, db_column='id_dificuldade', blank=True, null=True)
    id_faixa_etaria = models.ForeignKey('TbFaixasetarias', models.DO_NOTHING, db_column='id_faixa_etaria', blank=True, null=True)
    tempo_tela = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_criancas'


class TbDificuldades(models.Model):
    id_dificuldade = models.IntegerField(primary_key=True)
    descricao = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_dificuldades'


class TbFaixasetarias(models.Model):
    id_faixa_etaria = models.IntegerField(primary_key=True)
    faixa_etaria = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_faixasetarias'


class TbResponsaveis(models.Model):
    id_responsavel = models.AutoField(
        primary_key=True,
        editable=False
    )
    nome = models.CharField(max_length=80, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    dt_nascimento = models.DateField(blank=True, null=True)
    senha = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_responsaveis'


class TbTopicos(models.Model):
    id_topico = models.IntegerField(primary_key=True)
    descricao = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'tb_topicos'