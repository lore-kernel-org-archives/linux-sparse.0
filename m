From: Pavel Roskin <proski@gnu.org>
Subject: Bogus error for constant array sizes
Date: Thu, 29 May 2008 16:01:22 -0400
Message-ID: <1212091282.4265.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:54500 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbYE2UBY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 16:01:24 -0400
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 2FD33619058
	for <linux-sparse@vger.kernel.org>; Thu, 29 May 2008 16:01:23 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

I'm running sparse (the current git version) on this file:

static const int len = 64;
void foo(void);
void foo(void)
{
        int buf[len];
}

sparse test.c 
test.c:5:10: error: bad constant expression

But if I remove "const", the error message goes away.

The message comes from file expand.c, function __get_expression_value().
expr->type is checked to be equal EXPR_VALUE (1), but it's EXPR_PREOP
(9).

-- 
Regards,
Pavel Roskin
