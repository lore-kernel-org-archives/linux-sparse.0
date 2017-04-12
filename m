From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] extend canonical order
Date: Wed, 12 Apr 2017 15:08:45 +0200
Message-ID: <20170412130844.6rfns4lstgwej2au@macbook.local>
References: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36391 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdDLNIs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 09:08:48 -0400
Received: by mail-wm0-f41.google.com with SMTP id o81so87116837wmb.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 06:08:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

On Wed, Apr 12, 2017 at 02:59:10PM +0200, Luc Van Oostenryck wrote:
> After linearization, operands of binops of binops are
> maintained in a 'canonical' order but this order is only:
> 	anything > symbols > integer literals
> but there is some value to impose a more complete order
> as this creates more opportunities for CSE and help to
> limit the number of patterns that need to be checked
> at simplification of even during code generation.
> 
> This is what is done by this (almost single patch) series.
> 
> This series is available at:
> 	git://github.com/lucvoo/sparse.git base-file
> based on commit:
> 	c9585071d02590f40175ea90c395d15ef70e9a1e (cset-setfval)
> up to commit:
> 	462a61a21b1e3bb17abce88fb1bdbc93d9653245

Sorry, I forgot the completely edit my template.
This need to be read as:
	git://github.com/lucvoo/sparse.git cse-canonical

The SHA1 references are OK, though.

-- Luc
