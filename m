From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] remove unused "container" macro
Date: Wed, 13 Apr 2011 02:05:03 -0700
Message-ID: <BANLkTiktRmUDCjysa7qx3WYBzy5dKDVK9Q@mail.gmail.com>
References: <4D9E3D29.2000402@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54649 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1DMJFF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Apr 2011 05:05:05 -0400
Received: by vxi39 with SMTP id 39so276069vxi.19
        for <linux-sparse@vger.kernel.org>; Wed, 13 Apr 2011 02:05:03 -0700 (PDT)
In-Reply-To: <4D9E3D29.2000402@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: linux-sparse@vger.kernel.org

Applied.

Chris

On Thu, Apr 7, 2011 at 3:39 PM, Jan Pokorn=FD <pokorny_jan@seznam.cz> w=
rote:
> This macro seems to be unused since commit e7fb6e0 (4 years ago).
> But my estimation that it does not currently have any practical usage=
 for
> navigating through the sparse structures may be wrong.
>
> Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
> ---
> =A0ptrlist.h | =A0 =A03 ---
> =A01 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/ptrlist.h b/ptrlist.h
> index fbfc080..58d3bda 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -9,9 +9,6 @@
> =A0* (C) Copyright Linus Torvalds 2003-2005
> =A0*/
>
> -#define container(ptr, type, member) \
> - =A0 =A0 =A0 (type *)((void *)(ptr) - offsetof(type, member))
> -
> =A0/* Silly type-safety check ;) */
> =A0#define DECLARE_PTR_LIST(listname,type) =A0 =A0 =A0 =A0struct list=
name { type *list[1]; }
> =A0#define CHECK_TYPE(head,ptr) =A0 =A0 =A0 =A0 =A0 (void)(&(ptr) =3D=
=3D &(head)->list[0])
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
