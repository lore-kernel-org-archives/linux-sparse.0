From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Sparse preprocessing bug with zero-arg variadic macros
Date: Thu, 31 Aug 2017 08:34:00 -0500
Message-ID: <20170831133400.zjeaxhf25rbdftic@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbdHaNeG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 09:34:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6842EC056819
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2017 13:34:06 +0000 (UTC)
Received: from treble (ovpn-125-40.rdu2.redhat.com [10.10.125.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21F67779CD
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2017 13:34:06 +0000 (UTC)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

I think I'm seeing a bug in the sparse preprocessor.  I've reduced it to
the following test case.

----------------------
/* If the macro has arguments, prepend them with a comma. */
#define ARGS_APPEND(...) , ## __VA_ARGS__

#define __ARG17(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12,	\
		_13, _14, _15, _16, _17, ...) _17

/* Return 1 if the macro has arguments, 0 otherwise. */
#define HAS_ARGS(...) __ARG17(0, ## __VA_ARGS__, 1, 1, 1, 1, 1, 1, 1,	\
			      1, 1, 1, 1, 1, 1, 1, 1, 1, 0)

/* Macros for passing inline asm constraints as macro arguments */
#define ARGS(args...) args
#define OUTPUTS ARGS
#define INPUTS ARGS
#define CLOBBERS ARGS

#define __CLOBBERS_APPEND_0(...)
#define __CLOBBERS_APPEND_1(...)  , __VA_ARGS__

#define __CLOBBERS_APPEND(has_args, ...) \
	__CLOBBERS_APPEND_ ## has_args (__VA_ARGS__)

#define _CLOBBERS_APPEND(has_args, ...) \
	__CLOBBERS_APPEND(has_args, __VA_ARGS__)

/* If the macro has arguments, prepend them with a colon. */
#define CLOBBERS_APPEND(...) \
	_CLOBBERS_APPEND(HAS_ARGS(__VA_ARGS__), __VA_ARGS__)


void foo()
{
	ARGS_APPEND()
	CLOBBERS_APPEND()
}
----------------------

  $ gcc -c -o test.o test.c -E; cat test.o
  # 1 "test.c"
  # 1 "<built-in>"
  # 1 "<command-line>"
  # 31 "<command-line>"
  # 1 "/usr/include/stdc-predef.h" 1 3 4
  # 32 "<command-line>" 2
  # 1 "test.c"
  # 31 "test.c"
  void foo()
  {
  
  
  }

  $ sparse -c -o test.o test.c -E
  
  void foo()
  {
  			,
  			,
  }


Notice that sparse incorrectly inserts a comma for both macros when they
have zero arguments.

-- 
Josh
