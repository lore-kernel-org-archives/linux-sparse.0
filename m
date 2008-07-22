From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Handling of -specs in cgcc
Date: Tue, 22 Jul 2008 21:00:27 +0400
Message-ID: <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
References: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:1297 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbYGVRA1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 13:00:27 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1147702waf.23
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 10:00:27 -0700 (PDT)
In-Reply-To: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Morten Welinder <terra@gnome.org>

[Added the new address to the CC]

On Sun, Jul 20, 2008 at 10:28 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> Hi.
>
> Looking at cgcc, it seems that this code does not actually work,
>
> 26     if (/^-specs=(.*)$/) {
> 27         $check .= &add_specs ($1);
> 28         $has_specs = 1;
> 29         next;
> 30     }
>
> because add_specs() never expects to see a file name, and
> the option is removed from the argument list and never passed
> to gcc. As it seems that this feature never worked, probably
> we could simply remove it? Morten?
>
> ---
>
>    Pass -specs to gcc without trying (and failing) to decompose it.
>
>    Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
>
> diff --git a/cgcc b/cgcc
> index 4fab530..a1d4f66 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -23,12 +23,6 @@ foreach (@ARGV) {
>     $m32 = 1 if /^-m32$/;
>     $m64 = 1 if /^-m64$/;
>
> -    if (/^-specs=(.*)$/) {
> -       $check .= &add_specs ($1);
> -       $has_specs = 1;
> -       next;
> -    }
> -
>     if ($_ eq '-no-compile') {
>        $do_compile = 0;
>        next;
> @@ -83,6 +77,8 @@ sub cc_only_option {
>     # ones.  Don't include it just because a project wants to pass -Wall to cc.
>     # If you really want cgcc to run sparse with -Wall, use
>     # CHECK="sparse -Wall".
> +
> +    return 1 if $arg =~ /^-specs=.*/;
>     return 1 if $arg =~ /^-Wall$/;
>     return 0;
>  }
>
