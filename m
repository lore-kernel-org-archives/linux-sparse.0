From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 16:16:29 +0100
Message-ID: <46827F4D.7010305@knosof.co.uk>
References: <20070627103320.GA11047@localhost.sw.ru> <1182956472.8970.35.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:62832 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754706AbXF0PQd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:16:33 -0400
In-Reply-To: <1182956472.8970.35.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

Alex, Josh,

> On Wed, 2007-06-27 at 14:33 +0400, Alexey Dobriyan wrote:
>> sparse silently accepts some peculiar combinations of declaration
>> specifiers:

These are all permitted by the syntax of C.

6.7 Declarations, the init-declarator-list is optional.

>> "typedef extern;" passes.
...
>> Not sure how many different bugs there are here, though...

Sparse might flag the usage as suspicious, but it is not a bug.

> Several more:

The syntax permits:

signed unsigned short long double int;

> 
> int;
> void;
> int *;
> void *;
> static;
> extern;
> volatile;
> static foo;
> extern foo;
> volatile foo;
> int volatile;
> 
> - Josh Triplett
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
