From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.4.4-rc1
Date: Sat, 20 Aug 2011 15:59:36 -0700
Message-ID: <CANeU7QkxKZeaEDi_ZTOLDuSx+bP9xhOkmzbkOfvrGg1wZdWeFA@mail.gmail.com>
References: <CFCF4B72-0876-4248-908A-77F4BF367814@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53987 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab1HTW7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 Aug 2011 18:59:37 -0400
Received: by qwk3 with SMTP id 3so2499112qwk.19
        for <linux-sparse@vger.kernel.org>; Sat, 20 Aug 2011 15:59:36 -0700 (PDT)
In-Reply-To: <CFCF4B72-0876-4248-908A-77F4BF367814@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Dan Carpenter <error27@gmail.com>

It seems that my previous email get truncated.

It has been a long while since the last release. Mostly small
improvements. Noticeably the new gcc  build happier with
the new code.

The sparse project is the process of moving to the MIT license.
Thanks Dan for collecting the approvals.

So far we get most of the people sign off on the new license,
nobody objects yet. If you are the few people haven't reply
to the new license proposal, now it is a good time to do so.
Please reply to Dan off the list and Dan will aggregate the results.

Now, lets give the sparse code some test.

Chris

--

Ben Pfaff (1):
     evaluate: Allow sizeof(_Bool) to succeed.

Christopher Li (8):
     inspect: adding function arugument list
     Allow overwrite CFLAGS from command line
     Ignore attribute vector_size
     Remove set but not used variable
     inspect: Add switch statement and more
     validation: inline switch statement
     Fix inlining switch statement.
     Sparse 0.4.4-rc1

Diego Elio Petten=F2 (3):
     build: allow easy override of GCC_BASE
     build: add an all-installable target that builds the targets to in=
stall.
     Fix build with GCC 4.6 series.

=46lorian Fainelli (1):
     Makefile: warn user when libxml and/or libgtk2 are not available

Jan Pokorn=FD (4):
     remove unused "container" macro
     flow.c: make comment for `dominates' reflect code
     use ARRAY_SIZE() when possible (continued)
     parse.c: "if(" -> "if (" adjustment

Jonathan Neusch=E4fer (1):
     fix a memory leak in compile-i386.c

Linus Torvalds (2):
     Add new streams to a hash-list based on their names
     Teach 'already_tokenized()' to use the stream name hash table

Namhyung Kim (3):
     use ARRAY_SIZE() when possible
     Fix tokenizer for octal escape sequences
     Update the validation check for escape sequences

Nicolas Kaiser (1):
     memops.c: always true expression

Pekka Enberg (1):
     sparse: Add 'artifical' to ignore attributes
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
