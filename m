From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH] let sparse warn on &inline_function
Date: Sat, 20 May 2006 16:10:01 +0100
Message-ID: <446F3149.4060606@knosof.co.uk>
References: <200605201621.48466.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:49860 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964862AbWETPKF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 May 2006 11:10:05 -0400
In-Reply-To: <200605201621.48466.mb@bu3sch.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-sparse@vger.kernel.org

Michael,

> Let sparse warn, if we take pointers to inline functions.

I'm not sure if I understand the rationale for wanting to
do this.

Is it because you think taking the address will cause
an actual definition to be created (so its address can be
assigned) where there might not have been one in the first
place?

The inline specifier does not guarantee that the call will
be inlined.  It is only a hint to the compiler.

Presumably the address of a function is being taken because
it is needed.  What is the developer supposed to do instead?
Rewrite an algorithm?

Do you have any examples where this warning was useful?

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
