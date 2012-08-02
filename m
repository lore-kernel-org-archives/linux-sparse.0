From: Mauro Dreissig <mukadr@gmail.com>
Subject: Re: [PATCH 2/2] ptrlist.c: fix a typo in a comment
Date: Wed, 01 Aug 2012 23:59:27 -0300
Message-ID: <5019ED0F.6080507@gmail.com>
References: <1340055561-28496-1-git-send-email-j.neuschaefer@gmx.net> <1340055561-28496-2-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55493 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2HBC7b (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2012 22:59:31 -0400
Received: by yenl2 with SMTP id l2so8142762yen.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Aug 2012 19:59:30 -0700 (PDT)
In-Reply-To: <1340055561-28496-2-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 06/18/2012 06:39 PM, Jonathan Neusch=C3=A4fer wrote:
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  ptrlist.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ptrlist.c b/ptrlist.c
> index 2620412..5dc1117 100644
> --- a/ptrlist.c
> +++ b/ptrlist.c
> @@ -35,7 +35,7 @@ int ptr_list_size(struct ptr_list *head)
>   *
>   * The array to linearize into (second argument) should really
>   * be "void *x[]", but we want to let people fill in any kind
> - * of pointer array, so let's just call it "void *".
> + * of pointer array, so let's just call it "void **".
>   */
>  int linearize_ptr_list(struct ptr_list *head, void **arr, int max)
>  {
>=20

Hi!

It looks like the comment was left there by mistake. I belive the idea
was to call the second argument void * to avoid warnings when passing
other_type ** to the function without having to cast it to void **.

Reading the comment now only gives the idea that declaring the argument
as void ** instead of void *[] gives different semantics, which is not =
the case.=20

Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
