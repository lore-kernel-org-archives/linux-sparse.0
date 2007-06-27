From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 16:44:17 +0100
Message-ID: <468285D1.1020506@knosof.co.uk>
References: <20070627103320.GA11047@localhost.sw.ru> <1182956472.8970.35.camel@josh-work.beaverton.ibm.com> <46827F4D.7010305@knosof.co.uk> <20070627153133.GD11047@localhost.sw.ru> <4682836C.10201@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:42820 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753437AbXF0PoV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:44:21 -0400
In-Reply-To: <4682836C.10201@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

All,

>>> The syntax permits:
>>>
>>> signed unsigned short long double int;
>>
>> Please, read 6.7.2(2).
> 
> Semantic spoil sport.

The point I did not mention before sending the email
was the extent to which Sparse needs to check constructs
that are constraint violations and thus assumed to be checked
by the compiler.

Ok, it is possible to get weird looking stuff through sparse
without complaint, but is it worth spending time flagging it?

Surely time should be concentrated on flagging suspicious constructs
that are valid C and not in correctly handling obscure corners
of the language.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
