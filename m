From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 08/13] expression: recognize references to labels as
 address constants
Date: Tue, 26 Jan 2016 02:45:17 +0100
Message-ID: <20160126014516.GF46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87vb6hemcm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35212 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcAZBpW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 20:45:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so14641350wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 17:45:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87vb6hemcm.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:59:37PM +0100, Nicolai Stange wrote:
> As an extension, GCC allows labels to be referenced a la
>   label1:
>   ...
> 
>   void *ptr = &&label1;
> 
> Tag these label references as being address constants allowing them
> to be used as initializers for objects of static storage duration.

Would be good to add afew test case to show that.


Luc
