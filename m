From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [ANNOUNCE] LLVM backend for Sparse
Date: Mon, 29 Aug 2011 16:14:51 +0100
Message-ID: <4E5BACEB.7020502@knosof.co.uk>
References: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>	<CANeU7Q=PUDGGm9G6PnXvW3QeBnnMP39mfEE=HvszvBeAvrA4yQ@mail.gmail.com> <CAOJsxLEMvZMX9x0s4VGx9KMPdPbcHqtg0Q=o6ivSCamC3aHUrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:36798 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753528Ab1H2P7y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Aug 2011 11:59:54 -0400
In-Reply-To: <CAOJsxLEMvZMX9x0s4VGx9KMPdPbcHqtg0Q=o6ivSCamC3aHUrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

Pekka,

>>> Jeff Garzik and myself have been hacking on LLVM backed for Sparse. The
...
> It's alive!

Congratulations.  It is always great to see a compiler generate
executable code for the first time.

It is useful to have a semantic checker generate executable code
because it provides confirmation that lots of internal processing
is working as intended and therefore increases confidence
that the semantic checks are correct.

Can people allay my concern that this work is not on the slippery
slope leading to sparse becoming the recommended compiler for
building the kernel?

-- 
Derek M. Jones                   tel: +44 (0) 1252 520 667
Knowledge Software Ltd           blog:shape-of-code.codingguidelines.com
Source code analysis             http://www.knosof.co.uk
