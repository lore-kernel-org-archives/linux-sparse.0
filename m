From: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH v2] Define __CHAR_BIT__
Date: Tue, 28 Jan 2014 16:38:10 -0500
Message-ID: <20140128213810.GA27471@flamenco.cs.columbia.edu>
References: <CANeU7QnwK86w5TjboqjDm4xAPf0P9rw6bnp3jDWrF8j3C2vqQg@mail.gmail.com>
 <1389216762-10884-1-git-send-email-cota@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44049 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755475AbaA1Vj6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jan 2014 16:39:58 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 995FF20C5A
	for <linux-sparse@vger.kernel.org>; Tue, 28 Jan 2014 16:39:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1389216762-10884-1-git-send-email-cota@braap.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jan 08, 2014 at 16:32:42 -0500, Emilio G. Cota wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> gcc defines __CHAR_BIT__ as a pre-defined macro.
> 
> Define __CHAR_BIT__ in sparse so that code that needs it (e.g. code
> using CHAR_BIT from limits.h) does not generate false warnings.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Haven't seen any activity for this v2 since it was sent on
Jan 08--please take a look.

Thanks,

		Emilio
