From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/PATCH 1/2] sparse, llvm: Make function declaration accessible
 to backend
Date: Wed, 01 Feb 2012 20:03:29 -0500
Message-ID: <4F29E0E1.3000504@garzik.org>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org> <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54565 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab2BBBDb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 20:03:31 -0500
Received: by iacb35 with SMTP id b35so2281483iac.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 17:03:31 -0800 (PST)
In-Reply-To: <CANeU7Q=3mA3sjaj+rV=79qZxM_bYxDBUdMV4dECHprpKzey1Lg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@redhat.com>

On 02/01/2012 07:09 PM, Christopher Li wrote:
> Ok, this patch definitely works. However, I think there is ways to get the
> type without this patch. The more general question is, how to get type of
> any given pseudo register.


That is useful, yes.  But it does not address this specific problem.

We need the function declaration remembered, rather than what we have 
now -- a list of arguments with full type information, specific to its 
callsite.

You cannot deduce that a function call is/not varargs presently, even 
with a working pseudo->type setup.

varargs is just one of those annoying areas where the compiler needs to 
have rather specific knowledge, in order to properly construct a call

	Jeff


