From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 14/21] evaluate: recognize string literals as address
 constants
Date: Tue, 15 Mar 2016 18:46:51 +0100
Message-ID: <20160315174650.GM1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87wpqpgnjf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33792 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbcCORqy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:46:54 -0400
Received: by mail-wm0-f50.google.com with SMTP id p65so155611835wmp.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87wpqpgnjf.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:41:24AM +0100, Nicolai Stange wrote:
> Introduce support for recognizing string literals as address constants.
> 
> Make evaluate_string() unconditionally tag the *-preop wrapped symbol
> expression as being an address constant.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
