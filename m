From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 15/21] expression: recognize references to labels as
 address constants
Date: Tue, 15 Mar 2016 18:47:14 +0100
Message-ID: <20160315174713.GN1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87si1dgni5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36721 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbcCORrR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:47:17 -0400
Received: by mail-wm0-f51.google.com with SMTP id l124so20446698wmf.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:47:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87si1dgni5.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:42:10AM +0100, Nicolai Stange wrote:
> As an extension, GCC allows labels to be referenced a la
>   label1:
>   ...
> 
>   void *ptr = &&label1;
> 
> Tag these label references as being address constants allowing them
> to be used as initializers for objects of static storage duration.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
