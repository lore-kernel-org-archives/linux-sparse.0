From: Mike Holmes <mike.holmes@linaro.org>
Subject: Possible bug with _Static_assert & sparse
Date: Wed, 30 Jul 2014 13:32:39 -0400
Message-ID: <CADz3at1Hz5oiWT2MZvK2zOrtu7=1QYvny8RNE+QnoTOSJWHqWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41754 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbaG3Rck (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Jul 2014 13:32:40 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so1189237oag.7
        for <linux-sparse@vger.kernel.org>; Wed, 30 Jul 2014 10:32:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi

I wondered if the following sparse error indication was expected
behaviour or if it is a bug,
I would not expect sparse to error with "got 9"


$ cat static.c
#include <stdio.h>

#define fake 9
_Static_assert( fake > 8, "test message");

void main(void)
{
   printf("hello\n");
}
$ cgcc static.c -o static
static.c:4:17: error: Expected ) in function declarator
static.c:4:17: error: got 9
------------------------------------------------------------------

Changing the variable to fail the assert as expected the error persists

$ cat static.c
#include <stdio.h>

#define fake 8
_Static_assert( fake > 8, "test message");

void main(void)
{
   printf("hello\n");
}
mike@fedora1:~/git/odp$ cgcc static.c -o static
static.c:4:17: error: Expected ) in function declarator
static.c:4:17: error: got 8
static.c:4:1: error: static assertion failed: "test message"
 _Static_assert( fake > 8, "test message");
 ^

------------------------------------------------------------------

With regular gcc there is no issue and assert works as expected.

$ sparse --version
v0.5.0

Thanks Mike

-- 
Mike Holmes
Linaro Technical Manager / Lead
LNG - ODP
