From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [RFC PATCH 0/2] check for identical exprs on LHS and RHS of '&&'
Date: Wed, 10 Aug 2011 21:07:13 +1200
Message-ID: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56272 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1HJJHj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 05:07:39 -0400
Received: by gwaa12 with SMTP id a12so531928gwa.19
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2011 02:07:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi, I've started working on a new check for sparse to pick up a common 
error -- identical expressions appearing on both sides of some binary
operators.

This initially supports '&&', and incompletely -- but the plan is to
check instances of '!=', '==' and '||' the same way.

The check relies on recursively walking the ->left and ->right expressions, 
looking for differences. The implementation is a little verbose, but can 
be shared between all the operators.

What I'd like to know is:

* Do people consider this a worthwhile check to make?
* Am I "doing it right" with the expression walking?
* Are there other cases which people would be interested in?

Cheers

-- Chris

