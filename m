From: "Russ Cox" <rsc@swtch.com>
Subject: sparse context tags
Date: Mon, 12 Mar 2007 18:37:34 -0400
Message-ID: <ee9e417a0703121537p49657eai662b3dce82c7af5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:30769 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXCLWhe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Mar 2007 18:37:34 -0400
Received: by an-out-0708.google.com with SMTP id b33so1636892ana
        for <linux-sparse@vger.kernel.org>; Mon, 12 Mar 2007 15:37:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Is the optional leading context argument
(the x in __attribute__((context(x, 0, 1)))
documented anywhere?  Apologies if this is
a FAQ, but I've looked.

Failing that, can someone enlighten me about
why sparse doesn't find any problems with
the function bad() below?  I am using sparse-0.2.

Thanks.
Russ

---

#define __acquires(x) __attribute__((context(x, 0, 1)))
#define __releases(x) __attribute__((context(x, 1, 0)))

typedef struct redlock redlock_t;
typedef struct bluelock bluelock_t;

void redlock(redlock_t *r) __acquires(r);
void redunlock(redlock_t *r) __releases(r);

void bluelock(bluelock_t *b) __acquires(b);
void blueunlock(bluelock_t *b) __releases(b);

void
bad(redlock_t *r, bluelock_t *b)
{
	redlock(r);
	blueunlock(b);
}
