From: Pavel Roskin <proski@gnu.org>
Subject: Please make "no member" error more informative
Date: Thu, 31 May 2007 01:30:21 -0400
Message-ID: <1180589421.4159.58.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:41003 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXEaFaa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 May 2007 01:30:30 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HtdEh-00007k-0F
	for linux-sparse@vger.kernel.org; Thu, 31 May 2007 01:30:11 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HtdEr-0005WU-Ei
	for linux-sparse@vger.kernel.org; Thu, 31 May 2007 01:30:21 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

sparse reports the same error for two different situations.  Suppose
file test.c is:

struct ctl_table {
	int foo;
};

void test(struct ctl_table *sc)
{
	sc->ctl_name = 0;
}

$ sparse -Wall test.c 
test.c:7:4: error: no member 'ctl_name' in struct ctl_table

Rename the first ctl_table to ctl_table1, and the error will be the
same.

In the first case, the structure is known and lacks the requested
member.  In the second case, the structure is unknown.

I'll appreciate if somebody makes the messages different.  The message
is printed in evaluate_member_dereference() in evaluate.c.

Please test the case when only a forward declaration is available.  This
should be reported like the undeclared case.  Another test case is a
structure with no members.  It should be treated as declared.

-- 
Regards,
Pavel Roskin
