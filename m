From: Dan Sheridan <djs@postman.org.uk>
Subject: Over-eager code elimination?
Date: Tue, 20 Feb 2007 10:38:22 +0000
Message-ID: <1171967902.5848.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout01.dsvr.x-isp.net ([213.253.179.5]:55995 "EHLO
	mailout01.dsvr.x-isp.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932894AbXBTL3Z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Feb 2007 06:29:25 -0500
Received: from adelard.dsvr.co.uk ([212.69.201.135])
	by mailout01.dsvr.x-isp.net with esmtp id 1HJSOH-0000nu-A9
	for linux-sparse@vger.kernel.org; Tue, 20 Feb 2007 10:38:33 +0000
Received: from [80.229.44.105] (helo=[192.168.254.4])
	by adelard.dsvr.co.uk with esmtp (Exim 4.62)
	(envelope-from <djs@postman.org.uk>)
	id 1HJSO9-0005DF-E9
	for linux-sparse@vger.kernel.org; Tue, 20 Feb 2007 10:38:25 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Running test-linearize on some of my code, I seem to be losing an
assignment after a break.

In this minimal test code, y should have the previous iteration's value
of x, so the value returned is the difference between the final two
values from fetch():

int fetch(int);
int test(int v) {
  int x, y;
  for (int i=0; ; i++) {
    x = fetch(i);
    if (v < x) break;
    y = x;
  }
  return x-y;
}

test-linearize produces:
test:
.L0xb7db300c:
        <entry-point>
        br          .L0xb7db3034

.L0xb7db3034:
        call.32     %r2 <- fetch, $0
        setlt.32    %r5 <- %arg1, %r2
        dead        %r5
        br          %r5, .L0xb7db3084, .L0xb7db3034

.L0xb7db3084:
        dead        %r2
        sub.32      %r11 <- %r2, %r2
        dead        %r11
        ret.32      %r11

So it thinks that both x and y are in %r2. However, if y is initialised,
the assignment happens as expected.

Any ideas?

	Dan.
