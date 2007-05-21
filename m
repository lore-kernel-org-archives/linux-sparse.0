From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: Antwort: Re: Differences in the behaviour of sparse and gcc within cygwin
 environment
Date: Mon, 21 May 2007 15:20:22 +0200
Message-ID: <OF74B9333A.379DA3FD-ONC12572E2.00493908-C12572E2.004946CC@br-automation.com>
References: <20070518204735.GY4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.br-automation.com ([213.33.116.60]:40382 "EHLO
	mail1.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbXEUNUo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 May 2007 09:20:44 -0400
In-Reply-To: <20070518204735.GY4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

linux-sparse-owner@vger.kernel.org schrieb am 18.05.2007 22:47:35:

> On Fri, May 18, 2007 at 01:43:11PM +0200, Thomas Schmid wrote:
> > 1. Symbolnames with "$" are accepted by gcc but not by sparse
> 
> ewww...  It's not hard to change, but I strongly recommend making it
> ifdefed and *not* included on sane boxen.  Rationale: that affects one
> of the hottest paths in the entire thing.
> 
> Who uses $ in identifiers, anyway, when it's guaranteed to be 
non-portable?
> gcc accepts it as a bloody misguided extension, but it's not standard C 
by
> any stretch of imagination.  What are you working with, a bunch of old 
code
> originating on VMS?
> 
> > 2. #include "..\plc.h" is accepted by gcc but not by sparse => "\" is 
> > interpreted as escape- character
> > 3. #include "D:\plc.h" is accepted by gcc but not by sparse
> 
> *argh*
;-) Really that bad?
> 
> sparse takes a shortcut - it treats header-name as string-literal.  In
> principle, these are distinct tokens.  We could try to change that, 
but...
> that makes tokenizer context-dependent in a fairly upleasant way.
> 
> Note that \ in header-name is explicitly undefined behaviour (6.4.7(3)),
> and compilers I've seen on weird systems of that kind tend to remap / on 
\
> in header names anyway before trying to look for files to include.

The code which I like to use sparse with, is some sort of living 3rd party 
thing. 
I fear, these are not the only "misguided extensions" used, which work 
with cygwin GCC 2.95.3.

I also tried to pre-process that code with cpp - but then I lose the 
position-data of the declarations i try to get info from.
It's not possible to use cpp integrated in sparse, isn't it?


Best regards 
Thomas Schmid
