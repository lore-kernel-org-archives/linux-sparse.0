From: David Given <dg@cowlark.com>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Tue, 24 Jun 2008 14:29:05 +0100
Message-ID: <4860F6A1.7050701@cowlark.com>
References: <4856F196.8020403@cowlark.com>	 <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>	 <48584A33.7080602@cowlark.com>	 <70318cbf0806171741g4d099e92vf0c0e9d7588fd7d6@mail.gmail.com>	 <485C4150.2080508@cowlark.com> <70318cbf0806201840k18a51f94rcaa413b36fcfbbea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:48896 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYFXN3W (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 24 Jun 2008 09:29:22 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KB8an-000675-EK
	for linux-sparse@vger.kernel.org; Tue, 24 Jun 2008 14:29:53 +0100
Received: from [172.22.67.145] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 76EDB2008D
	for <linux-sparse@vger.kernel.org>; Tue, 24 Jun 2008 14:29:17 +0100 (BST)
In-Reply-To: <70318cbf0806201840k18a51f94rcaa413b36fcfbbea@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Christopher Li wrote:
[...]
> I agree we should probability make the ctype into instruction so
> make the back end easier.

That would be nice; in order to find the type of a pseudo that resulted 
from an instruction, I have to recurse back through *that* instructions' 
operands. This seems rather heavyweight.

In fact, because I need to associate a fair bit of data with each 
pseudo, I then cache the type information in the pseudo's user data 
structure, which for now is stored in an AVL tree keyed of the pseudo's 
address (there is no overkill; there is only 'open fire!' and 
'reload!'). May I put in a request for a user field on every sparse data 
structure, for doing this sort of thing, please?

Which brings me to my next question: while I'm now successfully 
compiling some code, including loops, I'm having trouble with other 
code. In particular, it would appear that now and again a bb will export 
a pseudo using one storage, and another bb will import the same pseudo 
but using a *different* storage. This is making it rather hard for me to 
correctly wire up the interconnects between basic blocks. Currently I'm 
working around this using data stored in my user data structure 
described above, but I suspect there's another thing here I'm not 
getting. What's the recommended strategy here?

(Incidentally, thanks for the help you've been giving me; it's been 
aiding me substantially.)

-- 
David Given
dg@cowlark.com
