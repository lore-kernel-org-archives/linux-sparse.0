From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [RFC] explicitly signed and friends
Date: Tue, 03 Jul 2007 16:38:49 +0100
Message-ID: <468A6D89.3050800@knosof.co.uk>
References: <20070702203008.GH21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:44961 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578AbXGCPiy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Jul 2007 11:38:54 -0400
In-Reply-To: <20070702203008.GH21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Al,

> 4)
> gcc is kinda-sorta tolerant to mixing pointers to signed and unsigned,
> unless you explicitly ask to be strict.  However, it's nowhere near
> as lenient as sparse.

Values wrapping because of signed/unsigned is a common cause of
faults.  In those contexts where the pointer is eventually dereferenced
to obtain a pointer I think sparse should continue to complain.

Differences of sign in pointer subtraction may or may not be regarded as
harmless.

I appreciate that gcc is currently an important compiler.  But I
know of several compiler groups who would like to be able to build
an executable kernel using their compiler.  Having sparse complain about
constructs that gcc is rather lax about means that those involved in
kernel development might fix the underlying problem in their code.
Such fixes are good in that they increase the probability that a
different compiler will successfully compile the kernel.  I think a
bit of competition in the kernel compiler market would help keep the
gcc people on their toes.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
