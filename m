From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/5] Fix an "'__sentinel__' attribute directive ignored"
 	warning
Date: Tue, 21 Jul 2009 22:41:11 +0100
Message-ID: <4A6635F7.1080403@ramsay1.demon.co.uk>
References: <4A62329B.9040107@ramsay1.demon.co.uk> <70318cbf0907201318s199fb9c4sc51d249461d18a57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:63067 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756278AbZGUV4i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 17:56:38 -0400
In-Reply-To: <70318cbf0907201318s199fb9c4sc51d249461d18a57@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Sat, Jul 18, 2009 at 1:37 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
>> This attribute was introduced in gcc 3.5. In order to avoid
>> such warnings, add a gcc version check when defining the
>> SENTINEL_ATTR macro. (This warning message, in particular,
>> was issued by a gcc 3.4.4 compiler).
> 
> Can you elaborate the error message you received?
> A small test program would be great.
> 
> Thanks

$ touch parse.c
$ make OS=cygwin parse.o
     CC       parse.o
parse.c:558: warning: `__sentinel__' attribute directive ignored
parse.c: In function `external_declaration':
parse.c:2619: warning: enumeration value `SYM_UNINITIALIZED' not handled in switch
parse.c:2619: warning: enumeration value `SYM_PREPROCESSOR' not handled in switch
parse.c:2619: warning: enumeration value `SYM_BASETYPE' not handled in switch
parse.c:2619: warning: enumeration value `SYM_NODE' not handled in switch
parse.c:2619: warning: enumeration value `SYM_PTR' not handled in switch
parse.c:2619: warning: enumeration value `SYM_FN' not handled in switch
parse.c:2619: warning: enumeration value `SYM_ARRAY' not handled in switch
parse.c:2619: warning: enumeration value `SYM_TYPEDEF' not handled in switch
parse.c:2619: warning: enumeration value `SYM_TYPEOF' not handled in switch
parse.c:2619: warning: enumeration value `SYM_MEMBER' not handled in switch
parse.c:2619: warning: enumeration value `SYM_BITFIELD' not handled in switch
parse.c:2619: warning: enumeration value `SYM_LABEL' not handled in switch
parse.c:2619: warning: enumeration value `SYM_FOULED' not handled in switch
parse.c:2619: warning: enumeration value `SYM_KEYWORD' not handled in switch
parse.c:2619: warning: enumeration value `SYM_BAD' not handled in switch
$

Note the first gcc warning. (The other warnings relate to patch #2)
Maybe this is easier to see:

$ make OS=cygwin CFLAGS=-Wno-switch-enum parse.o
     CC       parse.o
parse.c:558: warning: `__sentinel__' attribute directive ignored
$ 

Note also, that gcc 3.4.4 does not understand -Wno-attributes.
(ie I tried that alternative and it didn't work :( ).

My cygwin installation is about 2 years old and, unfortunately, I can't
update it on this machine. (The current cygwin gcc is at version 4.3.0).
Since this is due to an old gcc, maybe the simplest thing is for me to
just keep rebasing this patch in my cygwin repo. I don't need it on
Linux.

ATB,
Ramsay Jones

