From: conchur@web.de
Subject: Re: REGRESSION: implied: we have to make the false states match as
 well
Date: Sun, 20 Mar 2016 16:52:30 +0100
Message-ID: <trinity-4268de0c-d64e-4cce-9d0e-203e17956611-1458489150278@3capp-webde-bap12>
References: <trinity-31872b6a-6152-4832-aeb5-7ad863fb4a89-1458485302988@3capp-webde-bap48>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:51960 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbcCTPwd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 Mar 2016 11:52:33 -0400
In-Reply-To: <trinity-31872b6a-6152-4832-aeb5-7ad863fb4a89-1458485302988@3capp-webde-bap48>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Here is the minified versions of the first function:

    cat << EOF > test.c
    struct bar {
    	void *y;
    };
    
    struct bar *getit(void);
    int doit(struct bar *x);
    void putit(struct bar *x);
    
    int foo(void)
    {
    	int ret = 0;
    	struct bar *x;
    
    	x = getit();
    	if (!x || x->y)
    		goto out;
    
    	ret = doit(x);
    
    out:
    	if (x)
    		putit(x);
    
    	return ret;
    }
    EOF
    smatch -p=kernel --two-passes test.c

The problem seems to disappear when removing the "|| x->y".

The minified version of the second function:

    cat << EOF > test.c
    void *getit(void);
    void doit(void);
    
    void foo(void)
    {
    	void *a = (void *)0;
    	void *b = (void *)0;
    	void *c = (void *)0;
    	int d = 0;
    
    	a = getit();
    	if (a) {
    		b = getit();
    		c = getit();
    	}
    
    	if (c)
    		d = 1;
    
    	if (a && b && c)
    		doit();
    
    	if (d)
    		doit();
    }
    EOF
    CHECK="smatch -p=kernel --two-passes" cgcc  -c -o test.o test.c

It works when removing the "if (c)" + the next line
