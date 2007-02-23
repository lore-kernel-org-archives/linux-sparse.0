From: Pavel Roskin <proski@gnu.org>
Subject: Fun with Linux 2.6.21-rc1
Date: Fri, 23 Feb 2007 12:25:18 -0500
Message-ID: <1172251518.6229.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:36703 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946021AbXBWRZU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Feb 2007 12:25:20 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HKe97-000237-2C
	for linux-sparse@vger.kernel.org; Fri, 23 Feb 2007 12:23:49 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HKeAY-0001ii-G7
	for linux-sparse@vger.kernel.org; Fri, 23 Feb 2007 12:25:18 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

The current sparse reports many errors with Linux 2.6.21-rc1.  There are
screenfuls of errors for every file.  I have reduced one of them to this
simple file:

struct st {
	char c;
} __attribute__ ((aligned(2)));
struct st s1;
struct st s2;

$ sparse test.c 
test.c:5:18: error: Expected ( after asm
test.c:5:18: error: got s2
test.c:5:20: error: Expected ) after asm
test.c:5:20: error: got ;
builtin:0:0: error: expected declaration

The strange thing is that there is no "asm" here at all.

-- 
Regards,
Pavel Roskin
