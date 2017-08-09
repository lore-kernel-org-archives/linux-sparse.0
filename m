From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] patches for -rc5
Date: Wed, 9 Aug 2017 21:20:17 +0200
Message-ID: <20170809192015.li6dmzg3griy6uug@ltop.local>
References: <20170809004307.16663-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38298 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbdHITUW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:20:22 -0400
Received: by mail-wm0-f53.google.com with SMTP id f15so4451688wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:20:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170809004307.16663-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Wed, Aug 09, 2017 at 02:43:07AM +0200, Luc Van Oostenryck wrote:
> Chris,
> Please pull these patches for the upcoming release.
> No surprise here, it's the patches that have been on
> sparse-next, with no rebasing on external branches and
> some extra testing.
> 
> The following changes since commit fa71b7ac0594c9ddf81ec27753280cffef702489:
> 
>   Adding gcc attribute no_gccisr (2017-07-13 23:57:09 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/lucvoo/sparse.git tip
> 
> for you to fetch changes up to cccba8defbf0386305f522e63e1a1dd939f8c734:
> 
>   Bump sparse's version to -rc5 (2017-08-09 00:24:23 +0200)
> 

Having to take the commits that was already on sparse-next, I forgot
to take care of the SoB. I had thus to redo the thing.

It's the same request only that the correct reference is:
	4cdf1fa9bbd2116eb73510636dc6d79ecc185d9a

Sorry for that,
-- Luc
