From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Fri, 8 Jun 2012 19:55:44 -0400
Message-ID: <35CC6868-F462-4116-A143-81959DA38D5C@gmail.com>
References: <1339160327-8534-1-git-send-email-penberg@kernel.org> <4FD240E2.6040003@garzik.org> <CAOJsxLH9N84YwLrHQXn+R1r4cOd7DUuM2SpFq828mSV6WmHjqg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47790 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758327Ab2FHXzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 19:55:50 -0400
Received: by yenm10 with SMTP id m10so1680265yen.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 16:55:49 -0700 (PDT)
In-Reply-To: <CAOJsxLH9N84YwLrHQXn+R1r4cOd7DUuM2SpFq828mSV6WmHjqg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-sparse@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Jun 8, 2012, at 4:39 PM, Pekka Enberg wrote:
> 
> Xi, so I guess your current work on linearize.c might fix the SIGSEGV
> I'm seeing?

I guess the problem is that sparse-llvm generates an incorrect type
`load i64*' in llvm from the sparse instruction load.64.

	load.64     %r2 <- 0[foo]
	call.32     %r1 <- puts, %r2
	ret.32      $0

With the new ->ctype in pseudo sparse-llvm should be able to generate
the correct type.  I am playing with an LLVM backend with typed pseudos;
it generates the following code, which seems okay.

@0 = internal global [7 x i8] c"Foo !\0A\00", align 1
@foo = internal global i8* getelementptr inbounds ([7 x i8]* @0, i64 0, i64 0), align 8

define i32 @main(i32 %argc, i8** %argv) {
entry:
  %0 = load i8** @foo
  %1 = call i32 @puts(i8* %0)
  ret i32 0
}

- xi