From: Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH 0/2] allow casting unrestricted values
Date: Fri, 17 Feb 2017 15:08:37 +0000
Message-ID: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:56674 "EHLO
        nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934112AbdBQPIt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 10:08:49 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This series permits casting a value to a restricted type when the value is
 not a restricted value for that type.  In other words, it lets you cast 0
 to a bitwise type, which is consistent with the rules for implicit
 conversions.

Being new to the sparse codebase, I'm not 100% sure that I've passed the
 right thing to restricted_value's 'type' argument, especially as that
 argument doesn't appear to actually be used.

Edward Cree (2):
  Allow casting to a restricted type if !restricted_value
  Add test case for casts to restricted types

 evaluate.c                |  2 +-
 validation/bitwise-cast.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 validation/bitwise-cast.c

---
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
