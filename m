From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/16] instructions killing & operands usage
Date: Thu, 16 Feb 2017 05:56:52 +0100
Message-ID: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33101 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdBPE5Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:16 -0500
Received: by mail-wr0-f193.google.com with SMTP id i10so641550wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:15 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie aims at solving a number of problems caused by
imcomplete, missing or wrong handling of operands usage when
killing an instruction

Luc Van Oostenryck (16):
  add killing of OP_SLICEs
  add killing of OP_PHISOURCEs
  add helper kill_use_list()
  fix killing of OP_PHIs
  fix clear_phi(), replace it by kill_instruction()
  remove unused clear_phi()
  fix killing of otherwise not-handled instructions
  kill_instruction() may need to be forced or not
  add killing of pure calls
  fix killing OP_CALL via pointers
  add killing of non-volatile loads
  add killing of stores
  fix killing of rewritten loads
  use kill_instruction() when killing an OP_PHI during CSE
  use kill_instruction() when killing any instructions during CSE
  fix OP_PHI usage in try_to_simplify_bb()

 cse.c                            | 15 +--------
 flow.c                           |  7 ++--
 flow.h                           | 11 +++++-
 simplify.c                       | 73 +++++++++++++++++++++++++++++++---------
 validation/kill-cse.c            | 21 ++++++++++++
 validation/kill-load.c           | 17 ++++++++++
 validation/kill-phi-node.c       |  9 +++++
 validation/kill-phi-ttsbb.c      | 28 +++++++++++++++
 validation/kill-phisrc.c         | 21 ++++++++++++
 validation/kill-pure-call.c      | 17 ++++++++++
 validation/kill-rewritten-load.c | 16 +++++++++
 validation/kill-slice.c          | 19 +++++++++++
 validation/kill-store.c          | 16 +++++++++
 13 files changed, 236 insertions(+), 34 deletions(-)
 create mode 100644 validation/kill-cse.c
 create mode 100644 validation/kill-load.c
 create mode 100644 validation/kill-phi-ttsbb.c
 create mode 100644 validation/kill-phisrc.c
 create mode 100644 validation/kill-pure-call.c
 create mode 100644 validation/kill-rewritten-load.c
 create mode 100644 validation/kill-slice.c
 create mode 100644 validation/kill-store.c

-- 
2.11.0

