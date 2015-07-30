From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 0/3] Minor enhancements and fixes
Date: Wed, 29 Jul 2015 20:26:38 -0400
Message-ID: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33218 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbG3A0s (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Jul 2015 20:26:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com

[PATCH 1/3] .gitignore: add cscope and Qt project files
Useful if you're using cscope and Qt as an IDE

[PATCH 2/3] c2xml.c, parse.c: gcc 5+ stricter case statement parsing
The gcc 5.1.1 compiler complains if any of the possible values for the
switch variable are not covered by the case statement. Basically, it
forces the employment of the default case.

[PATCH 3/3] Add NOWARN and NOERR compile conditions
Provides compile conditionals to buid sparse without reporting
warnings and errors. This isn't quite reducing it to a tokenizer, but
it has the same effect for our application. Reports from the semantic
parser and the time they take are undesirable in our application.

 .gitignore |  7 +++++++
 c2xml.c    |  2 +-
 lib.c      | 21 +++++++++++++++++++++
 parse.c    | 13 +++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
