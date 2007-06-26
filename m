From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: support for C++ ?
Date: Tue, 26 Jun 2007 14:21:49 +0100
Message-ID: <468112ED.7050104@knosof.co.uk>
References: <Pine.LNX.4.64.0706252219310.12395@paik.artengine.ca> <4680A013.8030707@freedesktop.org> <4680F209.7070601@garzik.org> <46811043.90207@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:44386 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752877AbXFZNV4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 09:21:56 -0400
In-Reply-To: <46811043.90207@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Jeff Garzik <jeff@garzik.org>, Mathieu Bouchard <matju@artengine.ca>, linux-sparse@vger.kernel.org

Josh,

> While a C++ parser would add significant complexity to Sparse, I would still
> prefer to integrate it rather than encouraging people to fork.  I think a
> reasonable amount of code sharing would still exist between the C and C++
> code, and ideally almost all of the backend code would support both.

Experience suggests that a C++ front end is around a factor of seven
times larger than a C front end.

There are many more syntactic ambiguities in C++ that require
symbol table information to resolve (even then life can be tough).

Code sharing would be possible in the sense that if a C++ parser
were implemented it would be close to handling C out of the box.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
