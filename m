From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm switch constants must all be same type as switch value
Date: Mon, 13 Mar 2017 21:24:47 +0000
Message-ID: <CACXZuxfOP79gJbOD=02pPYWV4HQbnN0tRVWup77_etBxvhjAAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38890 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdCMVYt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 17:24:49 -0400
Received: by mail-it0-f51.google.com with SMTP id m27so40197882iti.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 14:24:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

While investigating errors that occurred when compiling 'minilua' I
found that the sparse-llvm output for switch statements is hard coded
to generate int32 values even when the switch is on a different
integer type. I believe following fix is needed in output_op_switch():

 FOR_EACH_PTR(insn->multijmp_list, jmp) {
  if (jmp->begin == jmp->end) {  /* case N */
   LLVMAddCase(target,
    LLVMConstInt(LLVMTypeOf(sw_val), jmp->begin, 0),
    jmp->target->priv);
  } else if (jmp->begin < jmp->end) { /* case M..N */
   assert(0);
  }
 } END_FOR_EACH_PTR(jmp);
