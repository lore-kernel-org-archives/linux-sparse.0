From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sindex: avoid a warning with 'case -1:'
Date: Sun, 5 Jul 2020 13:45:47 +0200
Message-ID: <20200705114547.ctqm5znkigrzkmyq@ltop.local>
References: <20200704235453.7756-1-luc.vanoostenryck@gmail.com>
 <20200705111204.lqutcuzkjkb4unl7@comp-core-i7-2640m-0182e6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgGELpv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 07:45:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A212CC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 04:45:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so39524704ejb.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 04:45:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200705111204.lqutcuzkjkb4unl7@comp-core-i7-2640m-0182e6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Jul 05, 2020 at 01:12:04PM +0200, Alexey Gladkov wrote:
> 
> Looks good :)
> 
> Reviewed-by: Alexey Gladkov <gladkov.alexey@gmail.com>

Thanks.
It's now pushed to the main tree.

-- Luc 
