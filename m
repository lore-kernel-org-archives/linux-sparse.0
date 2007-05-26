From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: pointer arithmetics and casts
Date: Sat, 26 May 2007 04:32:47 +0100
Message-ID: <4657AA5F.1020705@knosof.co.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk> <118833cc0705251814h9fffa39xc4a0f3f9e61242b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:21785 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbXEZDcz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 23:32:55 -0400
In-Reply-To: <118833cc0705251814h9fffa39xc4a0f3f9e61242b9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

Morten,

>>         BINOP[+]
>>                 <tree for p>
>>                 BINOP[*]
>>                         IMPLICIEDT_CAST[ptrdiff_t]
>>                                 <tree for i>
>>                         VAL[sizeof(*p)]
> 
> I don't think you want ptrdiff_t there.  It isn't guaranteed to
> be big enough.

It is also a signed type.

> size_t should do, though.

This is an unsigned type, so the wrap around behavior is defined.
But do you really want to map a small negative index into a large 
positive one?

You probably have to use intptr_t and uintptr_t.

On the other hand if sizeof(size_t) == sizeof(type_of(tree for i))
is an implicit cast needed?

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
