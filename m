From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] jffs2: fix sparse errors: directive in argument list
Date: Sun, 17 Nov 2013 13:40:03 -0800
Message-ID: <1384724403.2727.22.camel@joe-AO722>
References: <1384719513-27386-1-git-send-email-nunes.erico@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:33147 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752402Ab3KQVkH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Nov 2013 16:40:07 -0500
In-Reply-To: <1384719513-27386-1-git-send-email-nunes.erico@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Erico Nunes <nunes.erico@gmail.com>, linux-sparse@vger.kernel.org
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, 2013-11-17 at 18:18 -0200, Erico Nunes wrote:
> This patch fixes the following errors reported when running sparse:
> fs/jffs2/super.c:378:1: error: directive in argument list
> fs/jffs2/super.c:380:1: error: directive in argument list
> fs/jffs2/super.c:381:1: error: directive in argument list
> fs/jffs2/super.c:383:1: error: directive in argument list

Seems like a sparse error more than anything else.
(adding sparse mailing list)

Also you need to add a "Signed-off-by:" line
with your email address.

see: Documentation/SubmittingPatches

> ---
>  fs/jffs2/super.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 0defb1c..ec9e16f 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -361,6 +361,14 @@ MODULE_ALIAS_FS("jffs2");
>  static int __init init_jffs2_fs(void)
>  {
>  	int ret;
> +	const char desc[] =3D "version 2.2."
> +#ifdef CONFIG_JFFS2_FS_WRITEBUFFER
> +		" (NAND)"
> +#endif
> +#ifdef CONFIG_JFFS2_SUMMARY
> +		" (SUMMARY) "
> +#endif
> +		" =A9 2001-2006 Red Hat, Inc.";
> =20
>  	/* Paranoia checks for on-medium structures. If we ask GCC
>  	   to pack them with __attribute__((packed)) then it _also_
> @@ -374,14 +382,7 @@ static int __init init_jffs2_fs(void)
>  	BUILD_BUG_ON(sizeof(struct jffs2_raw_inode) !=3D 68);
>  	BUILD_BUG_ON(sizeof(struct jffs2_raw_summary) !=3D 32);
> =20
> -	pr_info("version 2.2."
> -#ifdef CONFIG_JFFS2_FS_WRITEBUFFER
> -	       " (NAND)"
> -#endif
> -#ifdef CONFIG_JFFS2_SUMMARY
> -	       " (SUMMARY) "
> -#endif
> -	       " =A9 2001-2006 Red Hat, Inc.\n");
> +	pr_info("%s\n", desc);
> =20
>  	jffs2_inode_cachep =3D kmem_cache_create("jffs2_i",
>  					     sizeof(struct jffs2_inode_info),



--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
