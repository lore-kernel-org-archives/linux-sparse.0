From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] whitespace & '-D' option
Date: Wed, 13 Dec 2017 18:15:25 +0100
Message-ID: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40284 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbdLMRPm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:15:42 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so6519114wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:15:42 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains two fixes concerning the '-D' option
and white spaces. A a bonus it also contains an improvement
to the testsuite which now respect quotes/whitespace in
commands' options.

Luc Van Oostenryck (6):
  add testcase for 'sparse -D M...'
  fix: accept 'sparse -D M...'
  testsuite: add test case for quoting of command's arguments
  testsuite: respect command line's quotes & whitespaces
  add test case for space within command line
  fix: spaces in macro definition on the command line

-- 
2.15.0

