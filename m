From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [patchset] rewrite of initializer handling
Date: Wed, 20 Jun 2007 10:54:02 +0200
Message-ID: <4678EB2A.7000106@redhat.com>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org> <20070618191653.GG21478@ftp.linux.org.uk> <46783975.4080704@redhat.com> <20070619224125.GP21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbXFTIya (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 20 Jun 2007 04:54:30 -0400
In-Reply-To: <20070619224125.GP21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Al Viro wrote:
> On Tue, Jun 19, 2007 at 10:15:49PM +0200, Michael Stefaniuc wrote:
>> Not sure if this is a poll but -Wparen-string doesn't add any new
>> warnings to the Wine run. And Wine has a "strange" way of specifying
>> wide char strings.
> 
> Oh?  FWIW, C99 way is L"......" for wide string literals and L'...' for
I know but that is not portable. A wchar is 16bit on Windows and 32bit 
in the normal world. gcc has the -fshort-wchar switch to make a wchar 
16bit but that still produces problems; afair when bridging between the 
hosts native 32bit wchar and Windows 16bit wchar. To avoid that Wine uses:
WCHAR s[] = {'H','e','l','l','o',' ','W','o','r','l','d',0};

> wide character ones.  sparse doesn't handle either and I'm not sure if
> we really want to open that can of worms...
There are only 6 .c files (out of around 2000) that do not parse in Wine 
due to missing support wide char character constant / string literal.
I had a look at sparse on how to fix it but it seems to require more 
than some trivial changes. I mean to implement it correctly and not just 
to stop sparse from mis parsing the rest of the file too.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
