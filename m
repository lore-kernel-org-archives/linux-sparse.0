From: =?UTF-8?B?SmFjZWsgxZpsaXdlcnNraQ==?= <sliwers@googlemail.com>
Subject: Defect in linearization of short circuit &&
Date: Sun, 14 Feb 2010 14:39:27 +0100
Message-ID: <4B77FD0F.50401@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060905080506010208080305"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:49412 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab0BNNjc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Feb 2010 08:39:32 -0500
Received: by ewy28 with SMTP id 28so3404099ewy.28
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2010 05:39:31 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905080506010208080305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I am attaching a small sample of code that triggers an issue with the 
linearization of &&.  Consider the condition within the parser_check 
function.  If st == NULL, then no more checks should be performed; the 
execution flow should immediately be directed to the "else" branch. 
However, if you output linearized version (e.g. by using "example" 
program), you will notice that it only skips the second check.

Could you help me investigate this issue?

I am using the latest sparse version from git.

Thank you!
Jacek


--------------060905080506010208080305
Content-Type: text/x-csrc;
 name="parser_check.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parser_check.c"

struct st {
        int value;
        struct st *other;
};

static void
execute_a (struct st *st, int i)
{
}

static void
execute_b (struct st *st)
{
}

static void
parser_check (struct st *st, int i)
{
        if (st && st->other && st->value > i && i > 0){
                execute_a (st, i);
        } else {
                execute_b (st);
        }
}

--------------060905080506010208080305--
