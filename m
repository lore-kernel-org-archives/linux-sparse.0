From: =?UTF-8?B?SmFjZWsgxZpsaXdlcnNraQ==?= <sliwers@googlemail.com>
Subject: Re: Defect in linearization of short circuit &&
Date: Mon, 15 Feb 2010 21:18:11 +0100
Message-ID: <4B79AC03.4010608@googlemail.com>
References: <4B77FD0F.50401@googlemail.com> <4B78655D.2080007@googlemail.com>	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>	 <4B799CA6.70807@googlemail.com> <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:65368 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220Ab0BOUSR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 15 Feb 2010 15:18:17 -0500
Received: by ewy28 with SMTP id 28so661470ewy.28
        for <linux-sparse@vger.kernel.org>; Mon, 15 Feb 2010 12:18:15 -0800 (PST)
In-Reply-To: <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Christopher Li pisze:
> 
> That is an optimization from Linus. It basically find out the simple variable
> case comparing variable and turn it into binary operations and avoiding the
> branch. It is cheaper to use "setne" than "cmp; jne; mov;".
> 
> It is safe because all the unsafe operations, e.g. dereferencing memory,
> should have set the cost high enough to avoid this optimization.
> e.g. all local variable dereferencing should be safe, because the address
> is in the stack.
> 
> Deferencing a pointer is not, so sparse will not optimize it.

Please, check my case.  The condition is:

if (st && st->other && st->value > i && i > 0)...

Obviously, if st is NULL, then the execution should be transferred 
immediately to the else branch.  But it does not.  It skips the second 
test and goes directly to the third one: st->value > i.  If a compiler 
was built with sparse as a frontend, execution of the generated code 
would end up with a segmentation fault.  And this code is perfectly valid.

So either it is an issue with the costs or it is an issue with the 
linearization.

Anyway, I believe that this case is worth fixing.
Jacek

