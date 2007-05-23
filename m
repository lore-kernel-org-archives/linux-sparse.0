From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: '$' as "valid" character in identifiers
Date: Thu, 24 May 2007 00:00:28 +0200
Message-ID: <4654B97C.7090100@redhat.com>
References: <4654B59A.50302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755195AbXEWWAb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 18:00:31 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4NM0Vho007041
	for <linux-sparse@vger.kernel.org>; Wed, 23 May 2007 18:00:31 -0400
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4NM0T1D009066
	for <linux-sparse@vger.kernel.org>; Wed, 23 May 2007 18:00:30 -0400
Received: from [10.32.4.19] (vpn-4-19.str.redhat.com [10.32.4.19])
	by pobox.stuttgart.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l4NM0SQB014435
	for <linux-sparse@vger.kernel.org>; Thu, 24 May 2007 00:00:28 +0200
In-Reply-To: <4654B59A.50302@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Michael Stefaniuc wrote:
> echo 'int dollar$ = 1;' > /tmp/dollar.c
> gcc -c -Wall -Wextra -o /tmp/dollar.o /tmp/dollar.c
> echo $?
> 0
> No comment ...
> 
> I didn't find '$' as valid identifier character in "The C Programming
> Language (ANSI C)" nor does http://c0x.coding-guidelines.com/5.2.1.html
> allow it as valid char in the "source character set".
> 
> I found it because sparse tripped over that in the Wine source code.
> Yes, i already sent a patch to fix that in Wine.
> 
> Not sure if sparse should change its behavior here;
> cgcc -c -Wall -Wextra -o /tmp/dollar.o /tmp/dollar.c
> /tmp/dollar.c:1:11: error: Expected ; at end of declaration
> /tmp/dollar.c:1:11: error: got $
> is a adequate response.
On a second thought something like:
/tmp/dollar.c:1:11: error: Invalid character '%c' in identifier
would be a better answer and make it more obvious what the problem is.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart
