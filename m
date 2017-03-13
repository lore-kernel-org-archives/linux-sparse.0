From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm handling of variadic function calls
Date: Mon, 13 Mar 2017 12:03:29 +0000
Message-ID: <CACXZuxdpJdzGCVbjnNcYvBGyRmtYv4JHGP4zbn43717DQELOwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36219 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdCMMDb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 08:03:31 -0400
Received: by mail-it0-f43.google.com with SMTP id w124so10668785itb.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 05:03:30 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

With the provision of type information in pseudo values, the following
modification allows variadic functions to be passed arguments
correctly. I have tested this with printf() mainly - probably more
rigorous testing is needed.

In output_op_call():

 FOR_EACH_PTR(insn->arguments, arg) {
  struct symbol *ftype = get_function_basetype(insn->fntype);
  LLVMValueRef value;
  if (arg->type == PSEUDO_VAL) {
   struct symbol *atype;
   atype = get_nth_symbol(ftype->arguments, i);
   /* Value pseudos do not have type information. */
   /* Use the function prototype to get the type. */
   if (atype)
    value = val_to_value(C, fn, arg->value, atype);
   else
    value = val_to_value(C, fn, arg->value, arg->sym);
  }
  else {
   value = pseudo_to_value(C, fn, insn, arg);
  }
  args[i++] = value;
 } END_FOR_EACH_PTR(arg);
