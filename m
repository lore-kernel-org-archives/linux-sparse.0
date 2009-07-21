From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/5] Fix some "plain integer as NULL pointer" warnings
 on 	cygwin
Date: Tue, 21 Jul 2009 22:54:07 +0100
Message-ID: <4A6638FF.4000108@ramsay1.demon.co.uk>
References: <4A623766.5020002@ramsay1.demon.co.uk> <70318cbf0907201331v1c830779i89c9bef9d6706115@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:61625 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756254AbZGUV4n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Jul 2009 17:56:43 -0400
In-Reply-To: <70318cbf0907201331v1c830779i89c9bef9d6706115@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Sat, Jul 18, 2009 at 1:58 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
[snip]
>>
>> $ cat -n null-test.sh
>>     1  #!/bin/bash
>>     2
>>     3  # The C99 standard says that the following headers define NULL:
>>     4  #   locale.h (7.11), stddef.h (7.17), stdio.h (7.19.1),
>>     5  #   stdlib.h (7.20), string.h (7.21.1), time.h (7.23.1),
>>     6  #   wchar.h (7.24.1).
>>     7
>>     8  for i in locale.h stddef.h stdio.h stdlib.h string.h time.h wchar.h
>>     9  do
>>    10          printf "%10s:  " $i
>>    11          printf "#include<%s>\nchar *xyz_ptr = NULL;\n" $i >t.c
>>    12          cgcc -E t.c | grep xyz_ptr
>>    13  done
>>    14  rm t.c
>>    15
>> $ ./null-test.sh
> 
> That is what I get in FC11:
>   locale.h:  char *xyz_ptr = ((void *)0);
>   stddef.h:  char *xyz_ptr = ((void *)0);
>    stdio.h:  char *xyz_ptr = ((void *)0);
>   stdlib.h:  char *xyz_ptr = ((void *)0);
>   string.h:  char *xyz_ptr = ((void *)0);
>     time.h:  char *xyz_ptr = ((void *)0);
>    wchar.h:  char *xyz_ptr = ((void *)0);
> 
> Which system has this problem?
> 

This is on cygwin. (as mentioned in the subject;P)

ATB,
Ramsay Jones

