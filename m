From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Fri, 15 Sep 2017 06:50:38 +0200
Message-ID: <20170915045037.6xmnzhimdkxo2w77@ltop.local>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43327 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdIOEuk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 00:50:40 -0400
Received: by mail-wm0-f52.google.com with SMTP id a137so957820wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 14 Sep 2017 21:50:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170914200327.15129-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Sep 14, 2017 at 10:03:27PM +0200, Uwe Kleine-König wrote:
> ---
>  cgcc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/cgcc b/cgcc
> index a8d7b4f217fe..0ab54f943578 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -235,6 +235,9 @@ sub add_specs {
>      } elsif ($spec eq 'linux') {
>  	return &add_specs ('unix') .
>  	    ' -D__linux__=1 -D__linux=1 -Dlinux=linux';
> +    } elsif ($spec eq 'gnu/kfreebsd') {
> +	return &add_specs ('unix') .
> +	    ' -D__FreeBSD_kernel__=1'
>      } elsif ($spec eq 'openbsd') {
>  	return &add_specs ('unix') .
>  	    ' -D__OpenBSD__=1';

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
