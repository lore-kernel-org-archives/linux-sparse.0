From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3 v2] .gitignore: add cscope and Qt project files
Date: Fri, 7 Aug 2015 23:58:21 -0400
Message-ID: <CANeU7Q=_+QH3gxvbkptqMh2uQEoRRoECXeQyR+esAKvS4iAHGw@mail.gmail.com>
References: <1438216001-8862-2-git-send-email-tcamuso@redhat.com>
	<1438623660-18026-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33208 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbbHHD6V (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 7 Aug 2015 23:58:21 -0400
Received: by ykoo205 with SMTP id o205so103513554yko.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Aug 2015 20:58:21 -0700 (PDT)
In-Reply-To: <1438623660-18026-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 3, 2015 at 1:41 PM, Tony Camuso <tcamuso@redhat.com> wrote:
>
> Signed-off-by: Tony Camuso <tcamuso@redhat.com>
> ---
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index d32d063..1e35eac 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -9,6 +9,7 @@
>  pre-process.h
>  sparse.pc
>  version.h
> +cscope*


Can we be more specific on the cscope files?
e.g. Will cscope.* works for you?

Just in case we can have some C file which starts
with "cscope". We do have "ctags.c" for example.

Chris
