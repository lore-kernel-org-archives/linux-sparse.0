From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [RFC] explicitly signed and friends
Date: Wed, 04 Jul 2007 01:51:13 +0100
Message-ID: <468AEF01.2040603@knosof.co.uk>
References: <20070702203008.GH21478@ftp.linux.org.uk> <468A6D89.3050800@knosof.co.uk> <20070703230141.GI21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:49059 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751529AbXGDAvc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Jul 2007 20:51:32 -0400
In-Reply-To: <20070703230141.GI21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Al,

>>> 4)
>>> gcc is kinda-sorta tolerant to mixing pointers to signed and unsigned,
>>> unless you explicitly ask to be strict.  However, it's nowhere near
>>> as lenient as sparse.
> 
>> Having sparse complain about
>> constructs that gcc is rather lax about means that those involved in
>> kernel development might fix the underlying problem in their code.
> 
> Compare the last two sentences...

I was running in Dr Who mode.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
