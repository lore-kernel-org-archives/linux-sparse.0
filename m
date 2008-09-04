From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 12:04:28 -0700
Message-ID: <70318cbf0809041204y75fa8f58vd6d1cfc7317b4fff@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
	 <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
	 <70318cbf0809040027i79476a4ds3d1086f5ca434d9d@mail.gmail.com>
	 <f19298770809040241h39703754i5bcac349e1d151c6@mail.gmail.com>
	 <70318cbf0809040335k5ea24032sffc11a8793b43b40@mail.gmail.com>
	 <f19298770809040629t1eb86f2co66a87e564bcd8684@mail.gmail.com>
	 <f19298770809040635s611ef3c3sa05111743ea60631@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:17956 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbYIDTEc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 15:04:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so510602fgg.17
        for <linux-sparse@vger.kernel.org>; Thu, 04 Sep 2008 12:04:29 -0700 (PDT)
In-Reply-To: <f19298770809040635s611ef3c3sa05111743ea60631@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 6:35 AM, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:

>> Ok, let me try to explain how the stuff works. Please note that in
>
> Ugh, my pretty code listings got corrupted by the bloody gmail.
> Here is a better version: http://zaytsev.su/explanation.txt

Thanks for your detail explain. It just confirm my reading of your
code. I stand by my original feedback:

- Using C source code as the output format is bad and unnecessary.
  It depend on gcc to process the intermediate C source file.

- Using dlopen to load the module does not have the fine grain control
  of the which symbol need to resolve and which is doesn't. The linked
  sparse object code for the whole linux kernel will be huge. Dynamic
  loading of 300M bytes of .so file is not fun.

- I can see you link all the define symbol together that way. In order to do
  inter-function check effectively, we need the have the reverse mapping
  as well. It need to perform task like this:
  "Get me a list of the function who has reference to spin_lock()".

  If I am writing a spin_lock checker.  I can look at who used spin_lock
  and only load those functions as needed.
  It is much better than scanning every single one of the kernel function to
  search for the spin_lock function call.

- The extra 4 bytes per structure storage on disk can be eliminated.
  I agree you need some meta data to track the object before you dump
  them to the file. But they don't need to be on the disk object at all.

  If you group same type of object together as an array. The index of the
  object is implicit as the array index. If the C struct is fixed size. It is
  trivial to locate the object.

  If the C struct is variable size, currently on sparse each object knows
  what size it is. You do need any index array to look it up. But this
  array can be build on object loading time. They don't have to be on
  the disk either.

  Then you can get ride of the wrapper structure on the disk file format
  all together.

  The writer patch I send out use those tricks already. You are welcome to
  poke around it.

Chris
