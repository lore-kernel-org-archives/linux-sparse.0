From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC 07/13] evaluate: check static storage duration
 objects' intializers' constness
Date: Sat, 9 Jan 2016 19:04:51 +0100
Message-ID: <20160109180450.GA2718@macpro.local>
References: <871tfzkcgi.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36108 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbcAISE4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jan 2016 13:04:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so20333303wmf.3
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jan 2016 10:04:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871tfzkcgi.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 23, 2015 at 01:19:09AM +0200, Nicolai Stange wrote:
> Initializers of static storage duration objects shall be constant
> expressions [6.7.8(4)].
> 
> Warn if that requirement is not met.
> 
> Identify static storage duration objects by having either of
> MOD_TOPLEVEL or MOD_STATIC set.
> 
> Check an initializer's constness at the lowest possible subobject
> level, i.e. at the level of the "assignment-expression" production
> in [6.7.8].
> 
> For compound objects, make handle_list_initializer() pass the
> surrounding object's storage duration modifiers down to
> handle_simple_initializer() at subobject initializer evaluation.


This patch makes validation/{builtin_bswap,choose_expr}.c fail.
Of course, it's directly related to the purpose of the patch but
then the test should be adapted.


Yours,
Luc
