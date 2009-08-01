From: Blue Swirl <blauwirbel@gmail.com>
Subject: [PATCH 0/2] builtins and __bounded__ attribute
Date: Sat, 1 Aug 2009 12:28:34 +0300
Message-ID: <f43fc5580908010228q6a2d7416l616816c3d104e181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:40771 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZHAJ2y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2009 05:28:54 -0400
Received: by fg-out-1718.google.com with SMTP id e21so733783fga.17
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2009 02:28:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

1/2 is a resend of:
http://marc.info/?l=linux-sparse&m=123642492815770&w=2

Please CC me for any replies.

Blue Swirl (2):
  Ignore attribute __bounded__, used by OpenBSD headers.
  Add a few GCC builtins

 lib.c   |   25 ++++++++++++++++++++++---
 parse.c |    2 ++
 2 files changed, 24 insertions(+), 3 deletions(-)
