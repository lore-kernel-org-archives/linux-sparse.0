From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [RFC] potential DR in handling of signed int and unholy mess
 in	our and gcc implementations
Date: Thu, 19 Mar 2009 12:10:47 +0000
Message-ID: <49C23647.5030209@knosof.co.uk>
References: <20090319013358.GZ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:19520 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375AbZCSM1p (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 08:27:45 -0400
In-Reply-To: <20090319013358.GZ28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

Al,

> 	First of all, C99 has rather unpleasant inconsistency between
> 6.7.2p5 and footnote in 6.7.2.1p9.  According to the former,

It is not really an inconsistency, one set of wording does not say
something about a particular case.

> However, the footnote in 6.7.2.1p9 says
>   "As specified in 6.7.2 above, if the actual type specifier
>    used is int or a typedef-name defined as int, then it is
>    implementation-defined whether the bit-field is signed or unsigned."

Ok, so the wording in 7.6.2 does not mention the typedef case.
At most this is an editorial change to the Standard.

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
