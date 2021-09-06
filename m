Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB88C433EF
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Sep 2021 19:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3520760724
	for <linux-sparse@archiver.kernel.org>; Mon,  6 Sep 2021 19:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbhIFTB7 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 6 Sep 2021 15:01:59 -0400
Received: from avasout01.plus.net ([84.93.230.227]:60919 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFTB7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Sep 2021 15:01:59 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Sep 2021 15:01:58 EDT
Received: from [10.0.2.15] ([195.213.6.49])
        by smtp with ESMTPA
        id NJk7mbqHL1q2pNJk8mpio6; Mon, 06 Sep 2021 19:53:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1630954401; bh=ONK2S1HEy23LlnMU+wLbduUgEr+660bSrQnSuyPojVw=;
        h=To:Cc:From:Subject:Date;
        b=R1T2gAxyxAoAE3naBTE38rwQqcWanYv3pWW4I4hsBPaQoUhyBZQHSR1+6gomfh5Zo
         TdSP5bBXsNrgEPm7h2v93NP8I4AZsIHy9qNzoDkXUI2nrQiD7fa5ffB0dHLnm1Vsg2
         aTYcBYvwOydR+goRV7TgKsvtPh6yPgBRm9harSxg339Ljj9EA5LLt/NhcOcs612LfR
         92bVZsx7I9za4CvfGZa8eDC3sB0qqGVYlfV5hyaPves2FeiThkqvuM80KWJE39razh
         xnLEPDkZ5Xw16YCbN7cXaWPUTFIgd29RZ416/kthxGlgaQ7PZvKBBt+HC4iHdX4SRL
         oH89yrtWfDlMw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=E/5WWZVl c=1 sm=1 tr=0
 a=ng+ES6eBAmcw5j0aA4HDOQ==:117 a=ng+ES6eBAmcw5j0aA4HDOQ==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8 a=mhcgMmqRw_umS8B6xqMA:9
 a=QEXdDO2ut3YA:10 a=EBOSESyhAAAA:8 a=wfVyg_xJWXzK9J-N3J8A:9 a=B2y7HmGcmWMA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: sparse v0.6.4
Message-ID: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
Date:   Mon, 6 Sep 2021 19:53:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DCCD01C529869640C883DA35"
Content-Language: en-GB
X-CMAE-Envelope: MS4wfL8f2Avg5ufvGcGG+x/3Fend+sbHmaATn0ufzU6VXylD/6G7I/kcFAZwrORB031GpUFJ7Ma+AcirFDEe2kyp4d2SX1rVlFuIWY5/x4/Z8IkHSWc5rui+
 EjVAbIAdwiBO+TfIJBIu/dsi6QecgDcSQ4wJa/ydw5u91bCtscYZZZdOlBYORhCqLsXSvB/WEHEjQw==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------DCCD01C529869640C883DA35
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hi Luc,

I have tested the new release, without issue, in the normal way on the
usual platforms (32- & 64-bit Linux, 64-bit cygwin).

[Have you posted to the sparse mailing-list yet? I think my subscription
has lapsed or something! I recently had to re-subscribe to the git
mailing-list as well. :( ]

Sorry for being tardy, but about 3 months ago a sparse issue came up on
the git mailing-list (see [1]). Take a look at this:

  $ cat -n junk.c
       1	
       2	static void func(int x)
       3	{
       4		switch (x) {
       5			default:
       6		}
       7	}
  $ sparse junk.c
  junk.c:6:9: error: Expected ; at end of statement
  junk.c:6:9: error: got }
  junk.c:8:0: error: Expected } at end of compound statement
  junk.c:8:0: error: got end-of-input
  junk.c:8:0: error: Expected } at end of function
  junk.c:8:0: error: got end-of-input
  $ 

Note: a case label that doesn't label a statement is not valid C, so what
is the problem? Well, for me, the implication of the email exchange was
that gcc seems to accept it without problem, except (with gcc 9.3.0):

  $ gcc junk.c
  junk.c: In function ‘func’:
  junk.c:5:3: error: label at end of compound statement
      5 |   default:
        |   ^~~~~~~
  $ 

... it doesn't for me!

So, I decided just to improve the error message issued by sparse. However,
that caused a moment of deja vu for me - hadn't you already fixed this
same issue? Having found your commit 0d6bb7e1 ("handle more graciously
labels with no statement", 2020-10-26), I realized that your fix only applied
for regular labels. The attached patch was the result of extending your
solution to case labels, like so:

  $ ./sparse junk.c
  junk.c:6:9: warning: statement expected after case label
  $ 

Note, just like your earlier commit, this issues a warning, rather than an
error (which it should probably be). I wrote this patch back in June, and
then forgot about it. :( [well, it was only lightly tested (testsuite and
one run over git), no tests, no commit message and it should probably be
an error!]

About a month ago, I noticed that gcc 11.2 had been released and the
release notes mentioned "Labels may appear before declarations and at the
end of a compound statement."  This, in turn, caused me to check my
current draft C2x document (dated December 11, 2020), which includes the
following:'N2508 Free Positioning of Labels Inside Compound Statements'.

It just so happens that, last night, I updated my cygwin installation and
the version of gcc went from 10.2 to 11.2. I think you can probably guess
what comes next:

  $ gcc -c junk.c
  $

  $ gcc -c -pedantic junk.c
  junk.c: In function ‘func’:
  junk.c:5:17: warning: label at end of compound statement [-Wpedantic]
      5 |                 default:
        |                 ^~~~~~~
  $ 

[Note: I tried several -std=cxx, but none of them even warned without
-pedantic]

So, for now, the standard does not allow these constructs, but the next
standard (whenever that will be) will.

ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/xmqqr1hlqd5v.fsf@gitster.g/

--------------DCCD01C529869640C883DA35
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-parse-warn-about-a-case-label-on-empty-statement.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-parse-warn-about-a-case-label-on-empty-statement.patch"

From 39f65942a4047a391ca8323ae109ae3c1fe14bd9 Mon Sep 17 00:00:00 2001
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Mon, 6 Sep 2021 19:00:57 +0100
Subject: [PATCH] parse: warn about a 'case label' on empty statement

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 parse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/parse.c b/parse.c
index bc1c0602..9f2a3cdf 100644
--- a/parse.c
+++ b/parse.c
@@ -2329,6 +2329,11 @@ static inline struct token *case_statement(struct token *token, struct statement
 	stmt->type = STMT_CASE;
 	token = expect(token, ':', "after default/case");
 	add_case_statement(stmt);
+	if (match_op(token, '}')) {
+		warning(token->pos, "statement expected after case label");
+		stmt->case_statement = alloc_statement(token->pos, STMT_NONE);
+		return token;
+	}
 	return statement(token, &stmt->case_statement);
 }
 
-- 
2.33.0


--------------DCCD01C529869640C883DA35--
